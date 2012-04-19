From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 19 Apr 2012 13:23:57 +0300
Subject: [RFC PATCH] cpuidle: allow per cpu latencies
In-Reply-To: <4F8FD773.5030500@linaro.org>
References: <1333619620-21201-1-git-send-email-pdeschrijver@nvidia.com>
 <4F7DA009.4010802@linux.intel.com>
 <CAMQu2gzwe0F3qcaTqASEPUASdG1SjpUxrBrSp-RrYLgy3W24OQ@mail.gmail.com>
 <4F7F0D52.8080305@linaro.org>
 <20120410102857.GA22721@tbergstrom-lnx.Nvidia.com>
 <20120416153456.GB514@tbergstrom-lnx.Nvidia.com>
 <4F8FD773.5030500@linaro.org>
Message-ID: <20120419102357.GJ514@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 11:14:27AM +0200, Daniel Lezcano wrote:
> On 04/16/2012 05:34 PM, Peter De Schrijver wrote:
> >>
> >> Maybe we also want to make the 'disabled' flag per CPU then or provide some
> >> other way the number of C states can be different per CPU?
> >
> > What do you think about this? Do we also want to make the disabled flag per
> > CPU? Or how should we deal with a different number of C states per CPU?
> 
> Hi Peter,
> 
> yes, that could makes sense. But in most of the architecture, this is 
> not needed, so duplicating the state's array and latencies is unneeded 
> memory consumption.
> 
> Maybe we can look for a COW approach, similar to what is done for the 
> nsproxy structure, no ?
> 

That could be easily solved by just having a pointer to the state table in the
per CPU datastructure I think?


Cheers,

Peter.
