From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Oct 2014 18:19:42 +0100
Subject: [PATCH] ARM: supplementing IO accessors with 64 bit capability
In-Reply-To: <CANLsYkwGtB0=VDFa-p11AGFA1XLjgGQGLa-U4WYtSs7-pHtVdw@mail.gmail.com>
References: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
 <20141022161155.GB27405@n2100.arm.linux.org.uk>
 <CANLsYkwGtB0=VDFa-p11AGFA1XLjgGQGLa-U4WYtSs7-pHtVdw@mail.gmail.com>
Message-ID: <20141022171942.GC27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 06:22:09PM +0200, Mathieu Poirier wrote:
> I had this conversation with a colleague who reviewed the work.  If
> the architecture is < 5 the __raw_ versions aren't included and the
> compiler won't complain until someone tries to use the macros.  We
> achieve the same result - the macros aren't accessible when the
> architecture doesn't support it - while saving an #if condition in the
> file.
> 
> I'm not strongly opinionated on this - I can enclose the macros in an
> #if statement.

What you're missing is that some driver may test for their presence by
doing:

#ifndef readq_relaxed
... do something else

which would now break as a detection method, as the macro is always
defined no matter whether it's present or not.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
