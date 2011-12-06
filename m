From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Dec 2011 21:59:11 +0100
Subject: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face
 detection
In-Reply-To: <CACVXFVOoQRZKDEWUtuq3hE3H25b7UUWWAJbsTGgVHJcUbnihig@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
 <CACVXFVO8Uk808J9HgVv6ernd4x_QwN3YsAaERF=W8F=NQrLwQw@mail.gmail.com>
 <CACVXFVOoQRZKDEWUtuq3hE3H25b7UUWWAJbsTGgVHJcUbnihig@mail.gmail.com>
Message-ID: <2893768.IFJoMOGMWT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 December 2011 23:45:27 Ming Lei wrote:
> >
> > and it is not difficult to implement it in a generic way so that new
> > array parameters can be supported as 64/32 compatible.
> 
> How about the below patch to support 64/32 compatible array parameter?

Looks technically correct to me, if you replace the 'return -ENOMEM' with
'ret = -ENOMEM;\n goto out;'.

The video_usercopy function already has multiple micro-optimizations
(on-stack buffers, cmd_input_size) that make it more complex than
I'd hope, but your addition seems ok to me.

Let's see what Mauro thinks.

	Arnd
