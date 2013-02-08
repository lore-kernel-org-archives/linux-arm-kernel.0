From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 Feb 2013 09:53:05 +0530
Subject: [PATCH 2/3] cpufreq: exynos: Adding cpufreq driver for exynos5440
In-Reply-To: <CADGdYn7FHa0Gnntpjs-K6T421=F0rZEhjyg-mkcsb_YDA6SZWQ@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
 <1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
 <CAOh2x=kYM8n8XipvQ0-3H5f=B2TwAeFSa0DP=hy+SWQvPXJh6Q@mail.gmail.com>
 <CADGdYn7+U1fvFdHkAikoH9P-owF0ZKk6ZSgrPfY+16S3vO=S3A@mail.gmail.com>
 <CAKohpon1J+7ZQu+Nevz_KBXpVa2Kus--DxR3cOhb97o-scB0fw@mail.gmail.com>
 <CADGdYn7FHa0Gnntpjs-K6T421=F0rZEhjyg-mkcsb_YDA6SZWQ@mail.gmail.com>
Message-ID: <CAKohponiPmGWtDOVXLe48dvZYweguaEmNb3b_7h+Agb3gxQLOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2013 08:56, amit kachhap <amit.kachhap@gmail.com> wrote:
>>>>> +       dvfs_info->dvfs_init = true;
>>>>
>>>> why do you need this ?
>>> This is added to synchronize the interrupts.
>>
>> How? You are setting it once in init() and not touching it afterwards. :)
>
> Yes but during init also if interrupts starts arriving before complete
> initialization so to protect that case it is there. I suppose there
> are other ways. Will check them

Then clear any pending interrupts from init ()
