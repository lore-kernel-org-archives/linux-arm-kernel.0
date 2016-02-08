From: Al.Grant@arm.com (Al Grant)
Date: Mon, 8 Feb 2016 17:44:49 +0000
Subject: [PATCH V2 3/6] stm class: provision for statically assigned
 masterIDs
In-Reply-To: <CANLsYkw=mG+ch8QzxmbwWs9o+mndVNo1MuqXcrPrNJYj_SQcHQ@mail.gmail.com>
References: <1454487337-30184-1-git-send-email-zhang.chunyan@linaro.org>
 <1454487337-30184-4-git-send-email-zhang.chunyan@linaro.org>
 <87mvrf5ngl.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYky2twQ98u241YyHD=atYRp1N56YVHUQNY2E2Ljsq0cseA@mail.gmail.com>
 <87twlj49k7.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkw=mG+ch8QzxmbwWs9o+mndVNo1MuqXcrPrNJYj_SQcHQ@mail.gmail.com>
Message-ID: <AM4PR08MB0785EAA2B628765D7EA3FDA086D50@AM4PR08MB0785.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Mike did write "master IDs are hardwired to individual cores and core security
> states", which make assignment for one platform very static.
> On the flip side those will change from one system to another.

It depends on your perspective.  From the perspective of a userspace
process not pinned to a core, the master id will appear to vary
dynamically and unpredictably as the thread migrates from one
core to another.  (That's actually useful if the decoder wants to know
where the thread is running at any given point, as it can find that out
for free, without the need to track migration events.)

On the other hand if you are pinned (e.g. you're the kernel on a
particular core, or you're a per-core worker thread in some thread
pooling system) then you have a fixed master id, and then you can
have one instance per core all using the same range of channel
numbers, with the master id indicating the core - this saves on
channel space compared to having to give each core its own
range of channel space.

Al
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
