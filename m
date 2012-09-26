From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 26 Sep 2012 19:38:58 +0530
Subject: [PATCH 1/2] spi:pl022: Disable/Enable functional clock from
 suspend/resume
In-Reply-To: <20120926121946.GO4428@opensource.wolfsonmicro.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
 <1348658647-25975-2-git-send-email-vipulkumar.samar@st.com>
 <CACRpkdampxUw0=NO6cs679C-r0_AnPEaTYVc+GppRkKGn32p-w@mail.gmail.com>
 <20120926121946.GO4428@opensource.wolfsonmicro.com>
Message-ID: <CAOh2x==aZbqYpPHvWyY7ReVi90TJAHbMLbk17o8wAOh+swbxzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 5:49 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Sep 26, 2012 at 02:17:36PM +0200, Linus Walleij wrote:
>> On Wed, Sep 26, 2012 at 1:24 PM, Vipul Kumar Samar
>
>> > SPI functional clock must be disalble/enable in non RTPM suspend/resume
>> > hooks. Currently it is only done for RTPM cases.
>
>> > This patch add support to disable/enbale clock for conventional
>> > suspend/resume calls.
>
>> Cross dependency between runtime suspend/resume and
>> common suspend/resume. Oh the horror ...
>
> This should be fine, we runtime resume before we suspend.

I believe Vipul sent this patch for the cases where RTPM in not
enabled in the configs.

--
viresh
