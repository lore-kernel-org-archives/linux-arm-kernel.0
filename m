From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 6 Feb 2016 12:55:37 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <CADyBb7vRKjDoeOfH=3Uwz+D0xyXaC9cM4ZSEO+MwL8Gw5T-Umg@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
 <56B2DEE4.7060901@roeck-us.net>
 <CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
 <56B4B4E2.40105@roeck-us.net>
 <CADyBb7sP=d+BWOdmNEAs38yRcmXVjYsFX=XNffNpGqfybpxTfQ@mail.gmail.com>
 <56B5363D.20200@roeck-us.net>
 <CADyBb7vRKjDoeOfH=3Uwz+D0xyXaC9cM4ZSEO+MwL8Gw5T-Umg@mail.gmail.com>
Message-ID: <56B641A9.3040801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> if (action) {
>          wdd->min_timeout = 1;
>          wdd->max_timeout = U32_MAX / gwdt->clk;
> } else {
>          wdd->min_timeout = 2;
>          wdd->max_timeout = U32_MAX / gwdt->clk * 2;
> }

Why would the minimum timeout be 2?  You can program WOR to timeout in 
half a second, can't you?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
