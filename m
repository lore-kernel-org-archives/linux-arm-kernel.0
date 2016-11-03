From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 3 Nov 2016 19:57:43 +0300
Subject: [PATCH] ARM: DTS: r8a7794: alt: Fix PCF names for DU
In-Reply-To: <1478180574-15464-1-git-send-email-jacopo@jmondi.org>
References: <1478180574-15464-1-git-send-email-jacopo@jmondi.org>
Message-ID: <085d178c-b0fb-ed42-79ce-590507baeba7@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/03/2016 04:42 PM, Jacopo Mondi wrote:

> Update the PCF pin groups and function names of DU interface for

    PFC maybe?

> r8a7794 ALT board.
>
> The currently specified pin groups and function names prevented PCF and
> DU interfaces from being correctly configured:
>
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> rcar-du: probe of feb00000.display failed with error -22
>
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>
> Patch applied against Simon Horman's renesas/master branch.
> The PCF pin groups and function renaming was introduced by commit 56ed4bb9 and
> DTS for ALT board has never been update accordingly.

    We didn't care about Alt at the time, the patch was done in the interests 
of the SILK board. I didn't realize the DU pin groups were used for Alt before 
the actual support was added for them. Thank you for finally fixing this!

> Tested displaying frames on VGA interface: the rcar-du driver loads correctly.

MBR, Sergei
