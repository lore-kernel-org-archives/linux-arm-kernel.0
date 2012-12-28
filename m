From: mikedunn@newsguy.com (Mike Dunn)
Date: Fri, 28 Dec 2012 13:07:28 -0800
Subject: [PATCH] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <87sj6qrpz7.fsf@free.fr>
References: <1356706349-3189-1-git-send-email-mikedunn@newsguy.com>
 <87sj6qrpz7.fsf@free.fr>
Message-ID: <50DE0A10.8040606@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roert, thanks again.

On 12/28/2012 10:28 AM, Robert Jarzmik wrote:
> Mike Dunn <mikedunn@newsguy.com> writes:
> 
>> This patch fixes some code that implements a work-around to a hardware bug in
>> the ac97 controller on the pxa27x.  A bug in the controller's warm reset
>> functionality requires that the mfp used by the controller as the AC97_RESET_n
>> line be temporarily reconfigured as a generic output gpio (AF0) and manually
>> held high for the duration of the warm reset cycle.  This is what was done in
>> the original code, but it was broken long ago by commit
>> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6, which changed the mfp to a GPIO input
>> instead of a high output.
>>
>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> 
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> As a side note, shouldn't this patch (as the other one on ALSA), once reviewed,
> be submitted to stable kernel ?


Dunno.  I'm kind of a newbie.  If the stable tree is for urgent fixes, well,
these have been broken for a long time.

Happy New Year!

Mike
