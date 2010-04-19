From: rbairva@gmail.com (rd bairva)
Date: Mon, 19 Apr 2010 15:58:29 +0530
Subject: Fwd: Dmaengine query
In-Reply-To: <m2vdbb048f61004190326ve4220de6za13c94eed059ec2@mail.gmail.com>
References: <v2mdbb048f61004132326r8ac75382k1e42321ff0ed484a@mail.gmail.com>
	<v2he9c3a7c21004141730vcc79dd58t5478c9d83af9816@mail.gmail.com>
	<m2vdbb048f61004190326ve4220de6za13c94eed059ec2@mail.gmail.com>
Message-ID: <s2ndbb048f61004190328u30aacb8ctdb66bacf061beeab@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Thu, Apr 15, 2010 at 6:00 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Apr 13, 2010 at 11:26 PM, rd bairva <rbairva@gmail.com> wrote:
>> Hi Dan,
>>
>> ? ? ? ?I am currently writing dmaengine compatible DMA driver for our ARM
>> based architecture, But I am facing some performance issues doing
>> that.
>>
>> 1. dmaengine says callback should run in tasklet, and next transfer
>> cannot be scheduled from the callback.
>>
>> Due to these restrictions I am getting some performance issue while
>> playing sound in our architecture.
>>
>>
>> Can callback call in DMA driver be placed out of spin_lock to submit
>> new operations from callback? (only in asynchronous case)
>>
>> is this Ok? please comment.
>
> Other dma driver authors are dropping the lock across the call to the
> callback in the mem-to-io case. ?The compliance points in the
> documentation are primarily targeted at the expectations of the
> async_tx api. ?In the mem-to-io (slave dma) model you are not using
> the async_tx api.
>
> --
> Dan
>

? ?My DMA controller supports device to device DMA transfers and we
need it in some of our drivers. Existing DMA engine framework doesn't
have support for device to device transfers.

Do you have any plans for device to device support in DMA engine?

Can you suggest me some other suggestion for doing this?


Regards
Ramdayal
