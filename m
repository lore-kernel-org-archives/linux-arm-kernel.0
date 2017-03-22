From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Wed, 22 Mar 2017 14:10:29 -0400
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170321113629.GW21222@n2100.armlinux.org.uk>
References: <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170319103801.GQ21222@n2100.armlinux.org.uk>
 <9b3311a8-34a7-2b5b-9bc7-836371e1e0a4@gmail.com>
 <179aca0a-deb5-7937-f955-26cc6d93afba@xs4all.nl>
 <20170320132930.GJ21222@n2100.armlinux.org.uk>
 <d0e2a9c2-5e94-d810-7ef4-ae089a6b25f5@xs4all.nl>
 <20170320141158.GK21222@n2100.armlinux.org.uk>
 <40e08d05-58cd-a295-3174-123147ee2ac5@xs4all.nl>
 <20170321104212.GC3784@bigcity.dyn.berto.se>
 <7fe51907-311d-e1cd-3e4c-dd3dc4af7d78@xs4all.nl>
 <20170321113629.GW21222@n2100.armlinux.org.uk>
Message-ID: <1490206229.21130.10.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 21 mars 2017 ? 11:36 +0000, Russell King - ARM Linux a ?crit?:
> ??????????????? warn: v4l2-test-formats.cpp(1187): S_PARM is
> supported for buftype 2, but not ENUM_FRAMEINTERVALS
> ??????????????? warn: v4l2-test-formats.cpp(1194): S_PARM is
> supported but doesn't report V4L2_CAP_TIMEPERFRAME

For encoders, the framerate value is used as numerical value to
implement bitrate control. So in most cases any interval is accepted.
Though, it would be cleaner to just implement the enumeration. It's
quite simple when you support everything.

Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/fad1c83e/attachment.sig>
