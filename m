From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 10:27:05 -0700
Subject: [PATCH] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <CAL_JsqLF4WbmuW5PQUKV0nb2GS=iiXnJzO=VmP1g=AT2d7o-WQ@mail.gmail.com>
References: <1381352107-32464-1-git-send-email-robherring2@gmail.com>
 <CAL_JsqLF4WbmuW5PQUKV0nb2GS=iiXnJzO=VmP1g=AT2d7o-WQ@mail.gmail.com>
Message-ID: <CAOesGMjF0R1MtXg=8BA26VAqMCmHe-Jj2Ffd+1q=j5mBmV7seA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 26, 2013 at 8:34 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Oct 9, 2013 at 3:55 PM, Rob Herring <robherring2@gmail.com> wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> As part of the effort to ultimately remove struct machine_desc, the
>> machine name is not really needed. It is only used for /proc/cpuinfo
>> "Hardware" field. Get this information from the DT instead and remove
>> the name string in the machine descriptor for DT machine descriptors. The
>> model or machine compatible property from the DT is used instead.
>>
>> This likely changes the name reported by /proc/cpuinfo. There could be
>> some userspace dependencies on the old name. Debian libdebian-installer
>> used to use this to determine kernel flavour, but now uses the DT
>> directly. It is not really a good idea for userspace to depend on this
>> anyway.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>> This is based on my early DT clean-up series[1] which I plan to go into
>> 3.13. This patch will require some coordination with arm-soc for any new
>> platforms if it goes into 3.13
>
> Olof, Kevin,
>
> Can you take this post rc1 or late in the merge window after all the
> new platforms have been merged? There are 6 new platforms queued for
> 3.13 last I checked which would break.

Yes, we can take it as soon as our branches have gone in, that's
probably easiest. Send a reminder if we forget.

(Also, feel free to not quote the whole patch next time :)


-Olof
