From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 19 Jul 2011 08:38:28 +0300
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <20110609171210.GB3877@ucw.cz>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<20110609171210.GB3877@ucw.cz>
Message-ID: <CAK=WgbY=gay-mLKhssinPhv1ic6FszGoLyLo9E6y7=3QOLx2FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Thu, Jun 9, 2011 at 8:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> So this is basically networking... right? Why not implement it as
> sockets? (accept, connect, read, write)?

This patch focuses on adding the core rpmsg kernel infrastructure. The
next step, after getting the basic stuff in, would be adding rpmsg
drivers, and exposing user space API.

For some use cases, where userland talks directly with remote entities
(and otherwise requires no kernel involvement besides exposing the
transport), socket API is very nice as it's flexible and prevalent.

We already have several rpmsg drivers and a rpmsg-based socket API
implementation too, but we'll get to it only after the core stuff gets
in.

Thanks,
Ohad.
