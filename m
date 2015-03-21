From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 21 Mar 2015 22:00:29 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150320101925.GC2071@katana>
References: <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana> <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana> <550B3725.10209@gmail.com>
 <20150320101925.GC2071@katana>
Message-ID: <20150321210028.GA1078@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I guess what you want to have is that i2c_add_adapter() is not called
> > for the disabled case, right?
> 
> I think that makes sense.

But maybe we should just start simple and keep calling i2c_add_adapter()
for the disabled case. We will just skip probing devices on the bus.
Would that help the issue you were originally trying to solve?


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150321/443aa47a/attachment.sig>
