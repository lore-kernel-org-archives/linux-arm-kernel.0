From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Oct 2013 16:38:25 +0200
Subject: [PATCH 06/10] clk: sunxi: mod0 support
In-Reply-To: <524A0B4A.8080902@elopez.com.ar>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
 <1380426579-32458-7-git-send-email-emilio@elopez.com.ar>
 <20130930173508.GF5287@lukather> <524A0B4A.8080902@elopez.com.ar>
Message-ID: <20131002143825.GA32149@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio

On Mon, Sep 30, 2013 at 08:37:46PM -0300, Emilio L?pez wrote:
> >>+static const struct factors_data sun4i_mod0_data __initconst = {
> >>+	.enable = 31,
> >>+	.mux = 24,
> >>+	.table = &sun4i_mod0_config,
> >>+	.getter = sun4i_get_mod0_factors,
> >>+};
> >
> >How are the parents handled here for the mux part? Do you expect the
> >different parents in a precise order in the device tree, so that you
> >have a direct mapping to the value to put in the muxing registers, or do
> >you have a smarter way to do it?
> 
> Indeed, the parents must be indicated on the DT using the same order
> as on the register. In other words, it works the same as all the
> other muxes we have implemented so far. The clock corresponding to
> bits 00 goes first, then the one corresponding to 01, etc.

Ok. It should be documented in the bindings doc then.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/0d81db3f/attachment.sig>
