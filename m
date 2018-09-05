From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 5 Sep 2018 16:00:36 +0200
Subject: [PATCH 11/13] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <20180905155741.22b7d0ef@bbrezillon>
References: <20180905095738.26406-1-brgl@bgdev.pl>
 <20180905095738.26406-12-brgl@bgdev.pl>
 <20180905155741.22b7d0ef@bbrezillon>
Message-ID: <CAMRc=Mco7Tbk5P_mgv49f+3j9DKYk5AL6EjPhwF7M=Hb7o5-Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-05 15:57 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Wed,  5 Sep 2018 11:57:36 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>>
>> +struct nvmem_cell_lookup {
>> +     const char              *nvmem_name;
>> +     const char              *dev_id;
>
> Shouldn't we have a con_id here?
>
>> +     const char              *cell_id;
>> +     struct list_head        node;
>> +};

I wanted to stay in line with the current API - nvmem_cell_get() takes
as argument a string called cell_id. I wanted to reflect that here.

Bart
