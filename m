From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 7 Feb 2016 00:37:39 +0300
Subject: [PATCH 4/5] ARM: dts: NSP: Add SP805 Support to DT
In-Reply-To: <CA+JzhdJa9juORA73TRjWbM=p4dZ1wbO=+RmkyOt9h8_MUU_FZw@mail.gmail.com>
References: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
 <1454712204-30419-5-git-send-email-jonmason@broadcom.com>
 <56B5EBCB.4080305@cogentembedded.com>
 <CAC3K-4p9kMALwg-Y355c-u06sAT-HLLY04=XMUer+R71OJLdcQ@mail.gmail.com>
 <CA+JzhdJa9juORA73TRjWbM=p4dZ1wbO=+RmkyOt9h8_MUU_FZw@mail.gmail.com>
Message-ID: <56B667A3.8010200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2016 11:47 PM, Scott Branden wrote:

>             Add support for the ARM SP805 Watchdog timer to the Northstar Plus
>             device tree.
>
>             Signed-off-by: Jon Mason <jonmason@broadcom.com
>             <mailto:jonmason@broadcom.com>>
>             ---
>                arch/arm/boot/dts/bcm-nsp.dtsi | 8 ++++++++
>                1 file changed, 8 insertions(+)
>
>             diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi
>             b/arch/arm/boot/dts/bcm-nsp.dtsi
>             index 415a0a6..0e8cb6e 100644
>             --- a/arch/arm/boot/dts/bcm-nsp.dtsi
>             +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
>             @@ -203,6 +203,14 @@
>                                      clock-frequency = <100000>;
>                              };
>
>             +               wdt at 39000 {
>
>
>             Should be "watchdog at 39000", according to ePAPR.
>
>
>     Thanks, I'll fix it and send it right out.

> I didn't know ePAPR was a requirement for a linux dtb?  We haven't done this
> with the wtd in other dts files.  Is this described somewhere?

    Nobody reads the docs. Like this:

http://www.devicetree.org/Device_Tree_Usage

    That page refers to the ePAPR 1.0 (not the most recent).

MBR, Sergei
