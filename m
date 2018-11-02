From: Ramana.Radhakrishnan@arm.com (Ramana Radhakrishnan)
Date: Fri, 2 Nov 2018 09:46:47 +0000
Subject: [PATCH v5 11/17] arm64: docs: document pointer authentication
In-Reply-To: <CAGXu5j+73z1dPS13xrOgPpn47sfwzNd9BO-USr7V+7quJt7yjA@mail.gmail.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <CAGXu5j+73z1dPS13xrOgPpn47sfwzNd9BO-USr7V+7quJt7yjA@mail.gmail.com>
Message-ID: <7f9c1bc4-2e82-e930-7d00-c26791ab9eef@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> +
>> +When CONFIG_ARM64_PTR_AUTH is selected, and relevant HW support is
>> +present, the kernel will assign a random APIAKey value to each process
>> +at exec*() time. This key is shared by all threads within the process,
>> +and the key is preserved across fork(). Presence of functionality using
>> +APIAKey is advertised via HWCAP_APIA.
> 
> It might be useful to include documentation here on how many bits of
> the address are being used for the PAC bits (I'm assuming it's 7?)


the number of bits available depends on the VA size, so you can't really 
document a number.

Ramana

> 
> -Kees
> 
