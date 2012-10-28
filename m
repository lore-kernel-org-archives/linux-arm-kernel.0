From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 28 Oct 2012 18:55:37 +0100
Subject: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on
 keypad config
In-Reply-To: <1351439163-9575-1-git-send-email-anarsoul@gmail.com> (Vasily
 Khoruzhick's message of "Sun, 28 Oct 2012 18:46:03 +0300")
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
Message-ID: <87vcduwkfa.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> Bootloader can leave interrupt bit pending, and it confuses driver.
OK, looks good to me.
One question though, just to make sure everything is covered :
  Suppose that the resume is the consequence of keypad press. If anybody relied
  previously on "reading the keypad" to know which key was pressed to wakeup the
  SoC, is it still working after your patch ?

And I suppose you can't "convince" your bootloader to behave correctly, can you ?

Cheers.

--
Robert
