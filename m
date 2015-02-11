From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Feb 2015 13:28:27 +0800
Subject: [systemd-devel] Making udev emit a signal when it is done
 loading modules
In-Reply-To: <20150128013852.GA8177@gardel-login>
References: <54BA20D0.7060402@redhat.com> <20150117160319.GO18247@in.waw.pl>
 <20150128013852.GA8177@gardel-login>
Message-ID: <20150211052827.GP2593@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 02:38:52AM +0100, Lennart Poettering wrote:

> To clarify this: if people do this, then this pulls in
> systemd-udev-settle.service, which slows down boot. Every service that
> does that is hence a majour source of slowness. 

> It's a hack to use this, not a solution. 

Well, yes.  There aren't really any good solutions with our event driven
model - we never "finish" booting, we just get to a point where nothing
has been happening for a while.  I have been thinking that we need to
just admit that properly and do something timer based - have a timer
that gets reset every time we instantiate something, then do all our
"end of boot" actions when nothing happened for a while.  It's not
elegant but I don't think elegant is a realistic goal here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150211/e5b16174/attachment-0001.sig>
