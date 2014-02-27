From: robie.basak@canonical.com (Robie Basak)
Date: Thu, 27 Feb 2014 11:36:04 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CAL_JsqJ+mXadxLHqFw6uXvM9=juC-emKT7G-d-_PLYbXNSX7Ew@mail.gmail.com>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <CAL_Jsq+3jBdca9zVnxHG+7pxy2_316emsP=PB3WkTMQP0JYBYQ@mail.gmail.com>
 <CAFEAcA8u6u8Hh=qn8XE2Evc93_-pkZPSDSShm-eiSn-vcsYgKA@mail.gmail.com>
 <CAL_JsqJ+mXadxLHqFw6uXvM9=juC-emKT7G-d-_PLYbXNSX7Ew@mail.gmail.com>
Message-ID: <20140227113604.GC643@mal.justgohome.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 05:08:38PM -0600, Rob Herring wrote:
> > What does the 8250 have to recommend it over just providing
> > the PL011?
> 
> As I mentioned, it will just work for anything that expects the serial
> port to be ttyS0 as on x86 rather than ttyAMA0. Really, I'd like to
> see ttyAMA go away, but evidently that's not an easily fixed issue and
> it is an ABI.

Kernel parameters (eg. console=...) are going to be embedded inside the
guest VM disk image inside a grub configuration or something like that,
right? Is there enough here to ensure that I can ship a guest VM disk
image that will correctly work (ie. use the right device) for both
kernel console output and userspace getty, regardless of what the host
is? Reading your post I realise that I'm not sure what I need to do to
make this work, since the device may be different. Can something be
recommended as part of the spec for this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/45b03c17/attachment.sig>
