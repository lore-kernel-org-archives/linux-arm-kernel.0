From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 28 Jun 2018 10:33:27 +0100
Subject: [PATCH v2 01/15] nvmem: add support for cell lookups
In-Reply-To: <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
References: <20180626102245.30711-1-brgl@bgdev.pl>
 <20180626102245.30711-2-brgl@bgdev.pl>
 <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
 <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
Message-ID: <1b3736c0-246e-4725-b64f-da916b9a0383@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/06/18 08:56, Bartosz Golaszewski wrote:
>> We should also have something like nvmem_remove_lookup_table() for
>> consistency, and it should ensure that it clears the cells entry too.
>>
> What do you mean by clearing the cells entry exactly?
I meant, Removing entry from the nvmem_cells list.

Initially I though we should remove the entry form nvmem_cells list, 
but It would complicate this path if some consumer has reference to it.

So, just removing the lookup list should be good! Lets not worry about 
removing from nvmem_cells list.


--srini

> 
> Bart
> 
