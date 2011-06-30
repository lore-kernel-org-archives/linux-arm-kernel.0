From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 30 Jun 2011 13:01:57 +0530
Subject: [PATCH 0/7] ARM: SAMSUNG: Cleanup SPI platform specific code
In-Reply-To: <1309436723-662-1-git-send-email-padma.v@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
Message-ID: <BANLkTin2MAsTn3UhJDOLVvsams=xRR=REQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 5:55 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> This patchset does the following:
>
> 1. Move duplicated code to common place
> [PATCH 1/7] ARM: SAMSUNG: Move SPI device definitions to plat-samsung
> SPI platform devices are defined in respective machine folder of
> Samsung S3C64XX and S5P series SoCs.This is duplicated for every SoC.
> So all SPI platform devices are moved to a common place.

The machine specific code is put in machine specific location for some reason.
And the code is not duplicated, it's mostly data structures
initialized with machine
specific values.

Have you considered if it would still be possible to build kernel
image supporting
more than 1 soc after your changes ?
