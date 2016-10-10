From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Oct 2016 23:24:55 +0200
Subject: [PATCH v2 3/8] PM / Domains: Allow domain power states to be read
 from DT
In-Reply-To: <20161010150301.GA44885@linaro.org>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-4-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFo62XuwsoqqPyFa7FYMutd2ng-xt9f7aFh_2T6ab=vAZg@mail.gmail.com>
 <20161010150301.GA44885@linaro.org>
Message-ID: <CAPDyKFru7fjqnxWbMdjsYu5ZMQd1j_vduAFXusWkwspVjzCMcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> +int of_genpd_parse_idle_states(struct device_node *dn,
>>> +                       struct genpd_power_state **states, int *n)
>>
>>
>> Instead of taking **states as a parameter, let's instead return it as
>> a pointer for the allocated struct. In case of failures, let's return
>> ERR_PTR().
>>
> Hmm.. I thought about it. There are 2 return values from this function.
> If we return a pointer to the allocated memory, we still have to return
> the size of it as an argument. I wasn't happy splitting the return
> values in 2 different places.

Ahh, right. So let's keep it as is!

[...]

Kind regards
Uffe
