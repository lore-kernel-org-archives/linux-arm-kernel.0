From: minipli@googlemail.com (Mathias Krause)
Date: Mon, 27 Jun 2011 06:29:12 +0200
Subject: [PATCH] arm, exec: remove redundant set_fs(USER_DS)
In-Reply-To: <BANLkTimFL44XRDeA6z6pvKGw-zpcdsNUEw@mail.gmail.com>
References: <BANLkTiknCeAxe30MJdVTxDom+ko8+EDQ4A@mail.gmail.com>
	<1307642718-22257-1-git-send-email-minipli@googlemail.com>
	<20110609155630.0f734351.akpm@linux-foundation.org>
	<1307711337-4042-1-git-send-email-minipli@googlemail.com>
	<20110610134821.GL24424@n2100.arm.linux.org.uk>
	<BANLkTimFL44XRDeA6z6pvKGw-zpcdsNUEw@mail.gmail.com>
Message-ID: <BANLkTikzPx8rTa9YSqccXA+zjM0YNJmyOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 3:53 PM, Mathias Krause <minipli@googlemail.com> wrote:
> On Fri, Jun 10, 2011 at 3:48 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Jun 10, 2011 at 03:08:57PM +0200, Mathias Krause wrote:
>>> The address limit is already set in flush_old_exec() so this
>>> set_fs(USER_DS) is redundant.
>>
>> Please show where and how this is done. ?I've looked and can't see
>> any equivalent call to set_fs() in flush_old_exec().
>
> Before dac853a (exec: delay address limit change until point of no
> return) it was done in search_binary_handler(), now it is done in
> flush_old_exec(). Either way set_fs(USER_DS) was/gets called before
> start_thread() so the call there is redundant.

Russell, any new opinion on this?

Mathias
