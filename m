From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 20 Jun 2015 07:48:41 +0530
Subject: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <20150619184403.GC22132@codeaurora.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
 <20150617133314.GB15153@linux>
 <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
 <55821F30.2090802@codeaurora.org> <20150618022543.GA28820@linux>
 <20150619184403.GC22132@codeaurora.org>
Message-ID: <20150620021841.GA1955@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-15, 11:44, Stephen Boyd wrote:
> On 06/18, Viresh Kumar wrote:
> > The problem you stated now was there with the current state of
> > bindings. The name is embedded into the OPP table node and so is fixed
> > for all the CPUs. Moving it to the CPU node will give all CPUs a
> > chance to name it whatever they want to. And the same list has to be
> > replicated to all CPUs sharing the clock rails.
> > 
> 
> Yes I don't see how the name will be different for any CPU, hence
> my complaint/question about duplicate names in each CPU. I guess
> it isn't any worse than clock-names though so I'm fine with it.

So what I wrote about the string being same for all CPUs, is valid
only to CPUs sharing clock line and hence OPPs. If there are CPUs with
independent lines, like in Krait, then the CPUs are free to choose
whatever name they want for the OPP tables, even if they are sharing
the same tables.

-- 
viresh
