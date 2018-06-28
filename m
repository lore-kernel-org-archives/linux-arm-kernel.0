From: geoff@infradead.org (Geoff Levand)
Date: Thu, 28 Jun 2018 09:15:28 -0700
Subject: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
In-Reply-To: <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
Message-ID: <ef039f0c-dea2-80d7-e6fa-481f3452a600@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 06/28/2018 03:25 AM, Ard Biesheuvel wrote:

> Given how the upstream kernel is aimed at future development, I don't
> think we should fix this in the upstream kernel at all. Distros are
> free to do what they like, of course, and I'm sure RedHat already have
> a fix for this in their downstream kernel. 

Debian expects the kernel to work correctly, and so won't add a fix.
That means CONFIG_ACPI_APEI can't be enabled, and so users must either
go without APEI or use a custom built kernel. See:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900581

-Geoff
