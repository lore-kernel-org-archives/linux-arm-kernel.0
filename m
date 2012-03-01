From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 1 Mar 2012 14:07:53 +0000
Subject: [PATCH 1/4] x86: add NO_IRQ macro
In-Reply-To: <6bda7538144dce0bf5780df3d0601147dae753b5.1330607068.git.rubini@gnudd.com>
References: <cover.1330607068.git.rubini@gnudd.com>
 <6bda7538144dce0bf5780df3d0601147dae753b5.1330607068.git.rubini@gnudd.com>
Message-ID: <20120301140753.5c44e27e@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Mar 2012 14:28:36 +0100
Alessandro Rubini <rubini@gnudd.com> wrote:

> This is needed to compile AMBA drivers. Most architectures define
> NO_IRQ as -1, and this does the same for the PC.

NAK

"No IRQ" is 0. There are a few platforms which incorrectly still define it
as -1 but they are broken and in fact many drivers won't work with
platforms that still incorrectly use -1. Nothing should be using a
NO_IRQ define.

Fix the users.


Alan
