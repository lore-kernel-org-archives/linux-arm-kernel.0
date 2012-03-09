From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 9 Mar 2012 17:40:17 +1100
Subject: [git pull] Consolidate cpuidle functionality
In-Reply-To: <CAMXH7KEwQM37R++8moXB8Q41_fBXOnVY2hXJGFQmTQ20oeFPEQ@mail.gmail.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
 <87y5reivhb.fsf@ti.com>
 <CAMXH7KEwQM37R++8moXB8Q41_fBXOnVY2hXJGFQmTQ20oeFPEQ@mail.gmail.com>
Message-ID: <20120309174017.081154936f57039b37c50435@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, 8 Mar 2012 19:58:23 -0600 Rob Lee <rob.lee@linaro.org> wrote:
>
>   git://git.linaro.org/people/rob_lee/linux.git cpuidle_consol_pull
> 
> These changes move various functionality duplicated in platform
> cpuidle drivers to the core cpuidle driver and common arch arm code. Also,
> the irq disabling in the platform code was removed as all calls into
> cpuidle_call_idle() will have already called local_irq_disable().
> 
> This patchset is bisect safe.  Also, the core cpuidle and arch changes of the
> first commit do not require any changes to the arch and platform cpuidle
> drivers, though those arch and platform change should be made to take
> advantage of the new consolidation function.
> 
> Stephen, this patch has been reviewed, tested, and ACK'd per the list above but
> cpuidle maintainer Len Brown has been out on vacation for a couple of weeks so
> I am sending you this pull request as time is running out to get this into
> v3.4.  I've had a brief communication with Andrew Morton about
> this as well so he is aware of this situation.  I am fairly new to the
> community so please let me know if you see anything that needs my attention or
> anything I should be doing differently.

I will add this tree from today.  Lets see if anyone screams.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/d26d231c/attachment-0001.sig>
