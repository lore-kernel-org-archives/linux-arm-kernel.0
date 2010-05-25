From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 25 May 2010 08:31:00 -0700
Subject: [PATCH 3/6] davinci: edma: clear events in edma_start()
In-Reply-To: <00f701cafc0e$23dedbf0$6b9c93d0$@raj@ti.com> (Sudhakar
	Rajashekhara's message of "Tue\, 25 May 2010 18\:58\:19 +0530")
References: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
	<1268841163-5868-4-git-send-email-khilman@deeprootsystems.com>
	<4BFA6A22.1000006@windriver.com> <871vd16wic.fsf@deeprootsystems.com>
	<4BFBA100.4020805@windriver.com>
	<00f701cafc0e$23dedbf0$6b9c93d0$@raj@ti.com>
Message-ID: <87d3wkov63.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Sudhakar Rajashekhara" <sudhakar.raj@ti.com> writes:

> Hi Stanley,
>
> On Tue, May 25, 2010 at 15:35:52, stanley.miao wrote:
>> Kevin Hilman wrote:
>> > <snip>
>> >>>
>> >>>       
>> >> This patch causes that the sound can not work normally on OMAP_L138.
>> >>
>> >>     
>> >
>> > Can you describe "can not work normally"?  Does that mean simply does
>> > not work, or works with pops & clicks etc.?
>> >
>> > Just to clarify... how did you isolate it to this patch.
>> >
>> > If you revert just this patch on current davinci git, do you have
>> > working sound as you expect again?
>> >   
>> Below is the test result:
>> 
>> $/root> aplay audiodump.wav
>> Playing WAVE 'audiodump.wav' : Signed 16 bit Little Endian, Rate 44100 
>> Hz, Stereo
>> aplay: pcm_write:1269: write error: Input/output error
>> $/root>
>> 
>> After revert it, the audio works fine.
>> 
>
> This patch works fine on DM644x which has McBSP but breaks audio on OMAP L138
> (as you had mentioned) which has McASP. Ideally McBSP/McASP should start after
> EDMA is started. If not then this patch clears the EDMA event which is actually
> set by McBSP/McASP. As this patch is working fine on DM644x, I think there is
> some issue in the audio driver which needs to be debugged.

In the mean time, I think it makes sense to revert $SUBJECT patch in
davinci git until the audio driver is debugged.

Kevin
