From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jul 2018 12:22:06 +0100
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <CAM5rFu8AiU6dORBGP5tfRp=fyvhNrbK8jpuhm=w4JVvONXgz5A@mail.gmail.com>
References: <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
 <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
 <20180719103916.g763zmsm7wnngwop@lakrids.cambridge.arm.com>
 <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
 <20180720062609.2haxhf23zyouoxmh@salmiak>
 <20180720064027.GA3901@jagdpanzerIV>
 <CAM5rFu8rQaVne22cYxx3YZTaxh9Dnq2wJWNu1uierBxZfogPeA@mail.gmail.com>
 <20180720094453.a64hnqoveojrozha@lakrids.cambridge.arm.com>
 <CAM5rFu8AiU6dORBGP5tfRp=fyvhNrbK8jpuhm=w4JVvONXgz5A@mail.gmail.com>
Message-ID: <20180720112206.ho6kweqg3ffsk5z4@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 04:27:50PM +0530, Hari Vyas wrote:
> Yes. As per earlier conversation, it was a bug in earlier kernel
> versions but  fact here is that bad_mode()-->die()-->__die()-->
> probably do_exit() handler is returning (in 4.14 wrongly) and latest
> too if such type of situation arises though looks difficult to create
> in normal scenario.

The intent is that bad_mode() should always be fatal, so we should fix
bad_mode() to ensure that this is always the case.

>From a quick look, it seems that will be rather messy; this code could
do with a cleanup. :/

Thanks,
Mark.
