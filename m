From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 18 Apr 2012 22:52:31 +0200
Subject: [PATCH 7/9] ARM: OMAP2+: SmartReflex: Use per-OPP data structure
In-Reply-To: <87y5pskiis.fsf@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-8-git-send-email-j-pihet@ti.com>
 <87y5pskiis.fsf@ti.com>
Message-ID: <CAORVsuXup38v0qhSSm7oeo5uzBN-Kd9T91_Zi4mtY_CG6L_QsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 8:21 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet at newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The SmartReflex driver incorrectly treats some per-OPP data as data
>> common to all OPPs (e.g., ERRMINLIMIT). ?Move this data into a per-OPP
>> data structure.
>
> OK
>
>> The SmartReflex driver should not be dependent on whether the host SoC
>> uses eFuses to store SmartReflex parameters or not. ?(Even SoCs that
>> do store SR data in eFuses often need to override that data with
>> software-defined values.) ?So, convert sr_retrieve_nvalue() to look up
>> per-OPP data by the OPP's nominal voltage, rather than by the eFuse
>> offset.
>
> Right.
>
>> While at it:
>> ?. tidy up the code wrt default values in the data tables,
>> ?. remove the global errminlimit debugfs entry and create per-voltage
>> ? ?entries from the data tables.
>
> OK
>
>> Furthermore, in order to make the SmartReflex implementation ready for
>> the move to drivers/, remove the dependency from the SR driver code
>> to the voltage layer by querying the data tables only from the SR device
>> init code.
>
> So that's 4 relatively independent things going on in this patch which
> makes it somewhat difficult to review and understand.
>
> I'd suggest breaking it up into smaller parts if possible. ?If not, fix
> up the changelog to describe why all of these need to go together, and
> why it's necessary to do them before the move.
Those changes are not independent from each other.
However for improved readability the patch can be split up (e.g.
efuse->opp, debugfs ...) and the changelog updated accordingly.

>
> Thanks,
>
> Kevin
>

Thanks,
Jean
