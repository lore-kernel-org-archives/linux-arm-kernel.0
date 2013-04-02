From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 2 Apr 2013 13:25:45 +0300
Subject: [PATCHv2 6/6] video: fb: vt8500: Convert framebuffer drivers
 to standardized binding
In-Reply-To: <1364878200-26343-7-git-send-email-linux@prisktech.co.nz>
References: <1364878200-26343-1-git-send-email-linux@prisktech.co.nz>
 <1364878200-26343-7-git-send-email-linux@prisktech.co.nz>
Message-ID: <515AB229.4050204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-04-02 07:50, Tony Prisk wrote:
> Now that a display timing binding is available, convert our almost identical
> binding to use the standard binding.
> 
> This patch converts the vt8500 and wm8505 framebuffer drivers and
> associated dts/dtsi files to use the standard binding as defined in
> bindings/video/display-timing.txt.
> 
> There are two side-effects of making this conversion:
> 
> 1) The fb node should now be in the board file, rather than the soc file as
> the display-timing node is a child of the fb node.
> 
> 2) We still require a bits per pixel property to initialize the framebuffer
> for the different lcd panels. Rather than including this as part of the
> display timing, it is moved into the framebuffer node.

This means that the boards using the current DT bindings won't work with
a kernel with these patches, right? Is that ok?

I don't have any idea how strict we should be with DT bindings in
keeping compatibility...

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/d22482fd/attachment.sig>
