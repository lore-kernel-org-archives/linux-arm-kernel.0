From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jun 2017 17:50:15 +0200
Subject: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <6d9d0d63-113e-b050-a54e-62746ebc6013@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-21-afaerber@suse.de>
 <CAK8P3a1fLABzSc7kej6uw751uoZma1Qvpm7c3mkLB45rcBNQTA@mail.gmail.com>
 <CAK8P3a3Pg2rm8nSPUm_E61F7+zSr3gWV6sNqhC0Et3Zh2xPtmA@mail.gmail.com>
 <6d9d0d63-113e-b050-a54e-62746ebc6013@suse.de>
Message-ID: <CAK8P3a1vCKkZ8i=MLQXHX5ZowWQGbqiMo3gQz1E9RV+8sSGfpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 5:22 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 29.06.2017 um 17:07 schrieb Arnd Bergmann:
>>
>> It seems you missed my question here. Can you please follow up, and
>> if possible send a patch to remove the pen_release logic that appears
>> to be unnecessary here?
>
> I do not have any documentation on these registers, only the downstream
> code that I forward-ported here. If you tell me what you mean exactly, I
> can do some testing and if it still works submit a patch to simplify it.
>
> Comments from the so far quiet Actions Semi side would help, too.

IIRC, there are two ways to implement SMP bootup: either you have
registers to tell the secondary CPU how to start up out of reset or they
get put into a holding pen during early boot where they spin waiting
for a variable to get written.

However, doing both is not necessary. See for example mach-sunxi
for an example without the holding pen. I think you can just delete
half of your file to do the same.

        Arnd
