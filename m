From: stano@meduna.org (Stanislav Meduna)
Date: Fri, 18 Apr 2014 16:45:18 +0200
Subject: BUG: spinlock trylock failure on UP - reverting timer patches
 helps
In-Reply-To: <CAOcfFMyTmQH-FwGE2YWoA76ypzBtWPYVTyi+4QpEMnrRtw8QVg@mail.gmail.com>
References: <534C3606.7010206@meduna.org>	<534C731F.1050406@meduna.org>	<534DADF1.6060608@meduna.org>	<53500184.4050309@meduna.org>	<53505BD7.9050004@meduna.org>
 <CAOcfFMyTmQH-FwGE2YWoA76ypzBtWPYVTyi+4QpEMnrRtw8QVg@mail.gmail.com>
Message-ID: <53513A7E.5050907@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.04.2014 01:10, jordan wrote:

Hi Jordan,

many thanks for the tests. I probably botched something during
the reverting - I now tried some more experiments and the system
now runs without BUGs and without kernel leak - of course
it needs some more uptime to be really sure.

My combined revert patch from 3.12.15-rt25 is at
  http://pastebin.com/MYLqbmZw
That was all that was needed.

> Yeah, i know a handful of people [amd users] that have now reported
> success booting into 3.14-rt1 reverting those patches.  Personally, I
> have disabled NO_HZ_FULL and have switched back to 'old tick' method
> in kconfig. I don't think the latest no_hz stuff is stable enough...

My problems were with periodic timers (I am on an embedded system
that runs things periodically anyway and I have also my doubts
regarding the stability), so the latest code did not break
only NO_HZ_FULL.

Thanks
-- 
                                       Stano
