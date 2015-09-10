From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Sep 2015 20:30:17 +0200
Subject: [linux-sunxi] [PATCH] musb: sunxi: Ignore VBus errors in
 host-only mode
In-Reply-To: <55F1CA9B.3070204@redhat.com>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
 <55C31963.2010701@schinagl.nl> <55C3709C.4080609@redhat.com>
 <55C47041.3000603@schinagl.nl> <55E93D8C.9020804@schinagl.nl>
 <55F1CA9B.3070204@redhat.com>
Message-ID: <20150910183017.GN9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 08:23:23PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 04-09-15 08:43, Olliver Schinagl wrote:
> >Hey Hans,
> >
> >On 07-08-15 10:45, Olliver Schinagl wrote:
> >><snip>
> >>>If you change the dr_mode to host then you _must_ also remove any id_det and vbus_det
> >>>gpio settings from the usb_phy node in the dts, as the sun4i phy code detects
> >>>host vs otg mode by checking for the presence of these.
> >>Yes, this fixes it and makes it work. Thanks.
> >>
> >I've been going back to this and am wondering if this is something I can look into to fix properly? E.g. if the dts sets dr_mode = host, can we simply ignore the pins and treat them as unset?
> 
> AFAIK you cannot unset something in dts. The only solution I
> can comeup with is to add a dr_mode argument to the phy like
> we already have for the otg controller itself.
> 
> This is something which we likely need to do anyways to add
> support for peripheral only mode, which we seem to need for
> some "hdmi sticks".

I haven't really followed the rest of the discussion, so sorry if you
already talked about that, but why can't you just set the dr_mode to
peripheral in such a case?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150910/9489360c/attachment.sig>
