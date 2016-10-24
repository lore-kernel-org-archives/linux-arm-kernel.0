From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 10:15:40 -0500
Subject: [PATCH 2/5] ARM: davinci: Don't append git rev to local version
In-Reply-To: <20f3efba-4f79-3675-d2ce-09efe90fb692@ti.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-3-git-send-email-david@lechnology.com>
 <20f3efba-4f79-3675-d2ce-09efe90fb692@ti.com>
Message-ID: <bf8cac01-910d-5afa-e840-f0d7ee96d22a@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 06:35 AM, Sekhar Nori wrote:
> On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
>> In the davinci default configuration, don't append the git revision to
>> the local kernel version by. This seems like the more desirable default
>> value.
>
> Why? To the contrary I actually quite like the fact that the git commit
> is appended to version string. Makes it easy for me to cross-check that
> I am booting the right image.
>
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>
> Thanks,
> Sekhar
>

Each time you make a commit, you get a new version, which installs 
another copy of the kernel modules on the device. This will fill up the 
SD card if you are making many commits.

Also, if someone wants to build the mainline kernel using the default 
configuration, it seems odd to have a git revision tacked on to the end 
even though you made no revisions.
