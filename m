From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 6 Oct 2015 17:48:42 +0200
Subject: [PATCH 0/8] Armada 38x SDHCI driver improvements
In-Reply-To: <87lhbg9hx7.fsf@free-electrons.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <87lhbg9hx7.fsf@free-electrons.com>
Message-ID: <CAPv3WKcFDVwdnBbTAbV2FGQu5s+WbLmM7s98mAJQc8hpUhW+9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

>
> Thanks for this series, it looks good I have only one or two comments.
>
> I also want to test it, how do you test the resume?
> using standby or suspend to ram (by hacking the kernel as currently we
> disbaled it) ?
>

Standby works even without the patch, as the registers' contents do
not disappear. I added rejected s2ram support on top of 4.3-rc4 and
used it. Today however I changed my card to another one and got -110
error (timeout) - I have to re-check it. Anyway the patch is needed
for sure, because without MBUS window configuration any access to the
card ends up with a kernel hang.

Best regards,
Marcin
