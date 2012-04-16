From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 16 Apr 2012 09:06:56 -0600
Subject: [PATCH V4 1/5] of: Implement managed of_iomap()
In-Reply-To: <201204161442.38725.arnd@arndb.de>
References: <cover.1334548272.git.viresh.kumar@st.com>
 <6a0872f9d8959bc9d66d179e4911d6f09a219b42.1334548272.git.viresh.kumar@st.com>
 <201204161442.38725.arnd@arndb.de>
Message-ID: <CACxGe6tec7y-9VNb9vNiPZhN6bt5MuMV0J18P_7Gk_pDwk-V=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 8:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 16 April 2012, Viresh Kumar wrote:
>> This simplifies cleanup paths of user code by providing managed version of
>> of_iomap().
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>
>
> This one looks good,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> but I wonder if we should also have a devm_of_request_and_ioremap
> (maybe with a shorter name) that combines this with request_resource.

Why is this function needed?  I'm directing drivers away from using
of_iomap now since the resource table is populated with the address
ranges at device registration time now.  New code should be using
platform_get_resource() if it is a platform device.

g.
