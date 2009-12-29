From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 29 Dec 2009 09:07:57 +0800
Subject: [PATCH 4/7] [ARM] locomo: allow cascaded IRQ base to be specified
	by platforms
In-Reply-To: <20091228211455.GA1612@ucw.cz>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
	<1261977488-18271-5-git-send-email-eric.y.miao@gmail.com>
	<20091228211455.GA1612@ucw.cz>
Message-ID: <f17812d70912281707x5f9048bawabafe2f20b2e396b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2009 at 5:14 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2009-12-28 13:18:05, Eric Miao wrote:
>> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> ---
>> ?arch/arm/common/locomo.c ? ? ? ? ? ? ? ? | ? 49 +++++++++++++++++-------------
>> ?arch/arm/include/asm/hardware/locomo.h ? | ? ?4 ++
>> ?arch/arm/mach-pxa/include/mach/irqs.h ? ?| ? ?6 ----
>> ?arch/arm/mach-pxa/poodle.c ? ? ? ? ? ? ? | ? ?7 ++++
>> ?arch/arm/mach-sa1100/collie.c ? ? ? ? ? ?| ? ?4 ++
>> ?arch/arm/mach-sa1100/include/mach/irqs.h | ? 11 +-----
>> ?6 files changed, 45 insertions(+), 36 deletions(-)
>
> How was this tested? Maybe ccing thomas would be good idea?
>

(.... Trying to think why Yinghai is Cc'ed here?)

Yeah, I almost forgot. Now Thomas CC'ed. I've roughly tested this
on SL-5600 (poodle), which seems to be all right. Yet, collie seems
to declare several sub-devices which are never used. Thomas' test
on this will be really appreciated.
