From: robh@kernel.org (Rob Herring)
Date: Fri, 19 May 2017 07:35:39 -0500
Subject: [PATCH v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
In-Reply-To: <a052da20-d9c7-69f5-21d9-9111d45702e6@collabora.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-10-romain.perier@collabora.com>
 <20170515214138.u63u7j53jogk3prm@rob-hp-laptop>
 <20170516111837.3uf5f5jbdkrnjudi@sirena.org.uk>
 <a052da20-d9c7-69f5-21d9-9111d45702e6@collabora.com>
Message-ID: <CAL_JsqJpcR0P03nixJqVHLhbVuuWAogx9YJSK4Gf4=01t8yfDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 1:56 AM, Romain Perier
<romain.perier@collabora.com> wrote:
> Hello,
>
>
> Le 16/05/2017 ? 13:18, Mark Brown a ?crit :
>> On Mon, May 15, 2017 at 04:41:38PM -0500, Rob Herring wrote:
>>> On Fri, May 12, 2017 at 03:22:25PM +0200, Romain Perier wrote:
>>>> This commit adds a compatible string for everest,es8323. This is an
>>>> audio codec that is compatible with es8328 and can be found for example
>>>> on the Firefly-RK3288 board.
>>> If it is compatible with the es8328, then that should be a fallback and
>>> you don't need the driver change.
>> While people don't strictly need the driver change it doesn't do any
>> harm either and encourages people to get the information into the DT
>> that it's a different chip.  Thinking about it it might be good to have
>> a way for something to validate if fallback compatibles are being listed
>> when they should - the drivers could provide the information fairly
>> easily I guess, or it could go into the binding docs once we have a
>> schema format.
>>
>> Even if it doesn't currently make a difference to software I'd rather
>> get the information in there for mixed signal devices like audio CODECs
>> - it's not that unknown to find later that supposedly register identical
>> chips have some differences in the analog which we want to care about.
> So, what should I do for this patch, finally ? fallback or driver change ?

Well, you could do both. However, there's not much point if you do the
driver change. So:

Acked-by: Rob Herring <robh@kernel.org>
