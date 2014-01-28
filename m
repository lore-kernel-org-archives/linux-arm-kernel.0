From: vkale@apm.com (Vinayak Kale)
Date: Tue, 28 Jan 2014 11:01:58 +0530
Subject: [PATCH] arm64: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <20140127122536.GE32608@arm.com>
References: <1390823984-23046-1-git-send-email-vkale@apm.com>
 <20140127122536.GE32608@arm.com>
Message-ID: <CAPrCYkf8Fg8et9TvUYKPDFxpW7Sfm3K_UR_Y0=kcO5_0XHAZPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 5:55 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Jan 27, 2014 at 11:59:44AM +0000, Vinayak Kale wrote:
>> Add DSB after icache flush operation.
>>
>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>
> I think we should also mention that this function is used for user
> addresses and an ISB is not required because of an exception return
> before executing user instructions.
Okay, will mention this. Thanks.
>
> --
> Catalin
