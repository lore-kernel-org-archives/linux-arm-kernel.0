From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Jun 2013 20:19:15 +0530
Subject: [PATCH V3 05/11] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <CAJFYCKGck29t211NTmXSKPtFdah3Pbe8T0UVZDsqWqqax3OL7g@mail.gmail.com>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-6-git-send-email-manjunath.goudar@linaro.org>
 <51C1A781.2040603@cogentembedded.com>
 <CAJFYCKGck29t211NTmXSKPtFdah3Pbe8T0UVZDsqWqqax3OL7g@mail.gmail.com>
Message-ID: <CAKohpon4ZZWAvvGO+gM-=pq2nka5wOxsJAcQ74m-sS4J4LGVSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2013 20:12, Manjunath Goudar <manjunath.goudar@linaro.org> wrote:
> On 19 June 2013 18:13, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> On 19-06-2013 16:12, Manjunath Goudar wrote:

>>>         struct usb_hcd *hcd = platform_get_drvdata(pdev);
>>>         struct ohci_hcd *ohci = hcd_to_ohci(hcd);
>>> +       bool    do_wakeup = device_may_wakeup(&pdev->dev);
>>> +       int             ret;
>>
>>
>>    There was no need to use tabs here, didn't you see that here the
>> variables aren't aligned?

> Instead of gmail you can use thunderbird mail there it is showing  proper
> alignment.

First try to understand what the actual comment is. He isn't complaining
about bad alignment but as hcd and ohci aren't aligned with tabs, you
don't require to add tabs to do_wakeup and ret.

--
viresh
