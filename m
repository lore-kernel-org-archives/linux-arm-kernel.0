From: olof@lixom.net (Olof Johansson)
Date: Mon, 15 Sep 2014 11:01:40 -0700
Subject: [PATCH v4 10/18] ACPI / table: Print GIC information when MADT is
 parsed
In-Reply-To: <20140915175250.8177DC40A42@trevor.secretlab.ca>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>
 <20140915064010.GD26649@localhost>
 <20140915175250.8177DC40A42@trevor.secretlab.ca>
Message-ID: <CAOesGMjcXYjmUzZqGncnkN-uhnLC1ey2vqeqE4MQ5UDm8BaYTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 10:52 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Sun, 14 Sep 2014 23:40:10 -0700, Olof Johansson <olof@lixom.net> wrote:
>> On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote:
>> > When MADT is parsed, print GIC information to make the boot
>> > log look pretty.
>>
>> If you do this for prettiness, having an example output in the commit
>> message would be a nice touch.
>
> Agreed.
>
>> The question is why it's needed though? Do we really need all this verbose
>> information in dmesg when it could be found out in other ways instead?
>>
>> x86 is notoriously verbose in some of these aspects, I'm not sure it's
>> something we need to mimic here?
>
> For consistency, it does make sense to have the common x86 and ARM64
> code outputing information in the same way, so I think the patch still
> makes sense. All of them could be moved to KERN_DEBUG as a separate
> patch if we want to cull early boot output. I would split that off and
> discuss it separately.

Yeah, pr_debug() makes sense here -- in particular if you're going to
have a potentially slow serial console to print all this to at info
level.

I disagree on order though, there's no reason to hold off fixing this
and doing it as a separate patch.


-Olof
