From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 17 Nov 2014 10:57:45 -0800
Subject: [PATCH v3 0/3] Amlogic Meson pinctrl driver
In-Reply-To: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
References: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
Message-ID: <7d408e1ab6ad46b9ba9010dd18b0df54@BY2FFO11FD038.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beniamino,

On Sun, 2014-11-16 at 09:14PM +0100, Beniamino Galvani wrote:
> Hi,
> 
> this is the third version of the pinctrl driver for Amlogic Meson. It
> provides a common infrastructure than can be used by all the SoCs of
> the family and configuration data specific for Meson8. Adding support
> for other SoCs should be only matter of defining new pins and banks.
> 
> The driver uses generic DT properties for the definition of mux and
> configuration nodes; since there is an ongoing effort to centralize
> the parsing to generic code, I've reused the patch "pinctrl:
> pinconf-generic: Infer map type from DT property" [1] posted a few
> days ago by Soren Brinkmann. I will update the series if that patch is
> going to change after the mailing list discussion.

Looks really nice to me and it's great that you use my patch as basis.
Looks like it works for more people than just me :)
I hope we can convince Linus to take that patch more or less as is. Even
though "kludgy" I don't see an easy way for addressing Linus' comments
without breaking current users of the interface. It may be easier/better
to gradually migrate to the newly defined bindings and remove the
kludgyness as user that rely on the current behavior disappear.

	Thanks,
	S?ren
