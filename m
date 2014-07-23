From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Jul 2014 16:18:51 +0530
Subject: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
In-Reply-To: <20140723121042.5b6f49e3@amdc2363>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
 <CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
 <20140723093824.5e51918f@amdc2363>
 <CAKohpok++gPcNk9-E4MsFdNBy8qL7oLYvatk1EvcW1OHwroZXQ@mail.gmail.com>
 <20140723121042.5b6f49e3@amdc2363>
Message-ID: <CAKohpomfGsvzJUn23-u-KoyNaY8sRaMLk0S4GdQJR0DxyscJWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 July 2014 15:40, Lukasz Majewski <l.majewski@samsung.com> wrote:

>> Shouldn't you use userspace governor then instead of performance?
>
> Performance assures that we will have the right frequency set.

Why wouldn't userspace assure that?

> However, there can be a similar patch to use userspace governor and
> various load to fail if ondemand's frequency flipping is detected.

That's why I want to get to the motive behind this patch.
AFAIU, we are checking if its fine to switch to available frequencies
or not and if yes, do we actually switch to those. Right?

For, this testcase we just need a single test and I still don't see why
performance is better than userspace?

>> And then we don't need the gzip stuff at all. We can just set it to
>> the right freq and get current freq to see if it matches?
>
> Sometimes "interresting" things show up when you have 100% CPU load and
> you try to switch frequency.

That's a different test then. And that's how it should be presented.
So, probably another option to the script, which isn't forced on people.
