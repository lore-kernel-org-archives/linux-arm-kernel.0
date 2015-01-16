From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 16 Jan 2015 09:36:56 +0100
Subject: [PATCH v3 4/4] mmc: sdhci: host: add new f_sdh30
In-Reply-To: <CAOEd-H3eU=OJQp5+-yzP02ccpzZdoBJ1BUeFoZiu-DhLYDhGWA@mail.gmail.com>
References: <1420803705-4539-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420803705-4539-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CAPDyKFqHk5cqFziwsDRa+RttjdiWZ9fYx9UP5nQdWEAJS=Cstg@mail.gmail.com>
 <CAOEd-H3eU=OJQp5+-yzP02ccpzZdoBJ1BUeFoZiu-DhLYDhGWA@mail.gmail.com>
Message-ID: <CAPDyKFp+sF5J2geen0K1SmU67O9vNDc_w8q92vq+ywZhv9snuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> +       pm_runtime_set_active(&pdev->dev);
>>> +       pm_runtime_enable(&pdev->dev);
>>> +       ret = pm_runtime_get_sync(&pdev->dev);
>>> +       if (ret < 0)
>>> +               dev_err(dev, "Failed to pm_runtime_get_sync: %d\n", ret);
>>
>> As I stated earlier I think this is a strange behaviour of how to
>> implement runtime PM support. Could you elaborate one more time why
>> this actually is needed?
>
> Thanks for pointing out this.
> We studied again and realized that this runtime PM support was only there for
> powerdomain management, but we have not yet upstreamed the powerdomain
> support. Thus we would like to remove it in next version.

I am fine with you removing the runtime PM support in the next
version. I also hope you to upstream the power domain support later
on, that would be nice.

A small note:
>From a driver perspective, you shall be able to implement runtime PM
support even if you haven't upstreamed the power domain support yet.
But, let's then deal with that as a separate patch later on.

Kind regards
Uffe
