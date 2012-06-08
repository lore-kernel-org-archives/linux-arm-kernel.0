From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 8 Jun 2012 09:21:13 +0200
Subject: [RFC] Support for H.264/MPEG4 encoder (VPU) in i.MX27.
Message-ID: <CACKLOr2jQMnBPTaTFOcfLN_9J1n39tLx-ffDcVGuZ4ZB-odYfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,

On 8 June 2012 08:51, javier Martin <javier.martin@vista-silicon.com> wrote:
> Hi Fabio,
>
> On 7 June 2012 19:35, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Javier,
>>
>> On Thu, Jun 7, 2012 at 5:30 AM, javier Martin
>> <javier.martin@vista-silicon.com> wrote:
>>
>>> As i stated, the driver is still in an early development stage, it
>>> doesn't do anything useful yet. But this is the public git repository
>>> if you want to take a look:
>>>
>>> git repo: https://github.com/jmartinc/video_visstrim.git
>>> branch: ?mx27-codadx6
>>
>> Thanks, I will take a look at your tree when I am back to the office next week.
>>
>> I also see that Linaro's tree has support for VPU for mx5/mx6:
>> http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=summary
>>
>> ,so we should probably think in unifying it with mx27 support there too.

If you refer to driver in [1] I have some concerns: i.MX27 VPU should
be implemented as a V4L2 mem2mem device since it gets raw pictures
from memory and outputs encoded frames to memory (some discussion
about the subject can be fond here [2]), as Exynos driver from Samsung
does. However, this driver you've mentioned doesn't do that: it just
creates several mapping regions so that the actual functionality is
implemented in user space by a library provided by Freescale, which
regarding i.MX27 it is also GPL.

What we are trying to do is implementing all the functionality in
kernel space using mem2mem V4L2 framework so that it can be accepted
in mainline.

Please, correct me if the driver you are talking about is not the one in [1].

Regards.

[1] http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=blob;f=drivers/mxc/vpu/mxc_vpu.c;h=27b09e56d5a3f6cb7eeba16fe5493cbec46c65cd;hb=d0f289f67f0ff403d92880c410b009f1fd4e69f3
[2] http://www.mail-archive.com/linux-media at vger.kernel.org/msg36555.html

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
