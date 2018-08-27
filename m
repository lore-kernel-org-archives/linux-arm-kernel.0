From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 27 Aug 2018 17:18:26 +0200
Subject: [PATCH 0/4] arm64: wire CRC32 instructions into core crc32
 routines
In-Reply-To: <20180827145352.GF2311@thunk.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827145352.GF2311@thunk.org>
Message-ID: <CAKv+Gu_qz+HbU2HQ2ep0cN-9V5hA46sBNVoxvkyjDQ=ZGk8yfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 August 2018 at 16:53, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Aug 27, 2018 at 01:02:41PM +0200, Ard Biesheuvel wrote:
>> While this is not known to cause performance issues, calling a table based
>> time variant implementation with a non-negligible D-cache footprint (8 KB)
>> is wasteful in any case, and now that the crc32 instructions have been made
>> mandatory in the architecture, let's wire them up into the core crc routines.
>
> Stupid question --- are there any arm64 SOC's out there which do *not*
> have the crc32 instructions?  Presumably there won't be in the future,
> because it's now mandatory --- but where there any in the past?
>

Yes, the APM Xgene for instance.
