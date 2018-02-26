From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Feb 2018 18:05:21 +0000
Subject: [PATCH v2 2/2] arm64: Expose Arm v8.4 features
In-Reply-To: <20180207142106.10716-2-suzuki.poulose@arm.com>
References: <20180207142106.10716-1-suzuki.poulose@arm.com>
 <20180207142106.10716-2-suzuki.poulose@arm.com>
Message-ID: <20180226180521.GH26147@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 02:21:06PM +0000, Suzuki K Poulose wrote:
> Expose the new features introduced by Arm v8.4 extensions to
> Arm v8-A profile.
> 
> These include :
> 
>  1) Data indpendent timing of instructions. (DIT, exposed as HWCAP_DIT)
>  2) Unaligned atomic instructions and Single-copy atomicity of loads
>     and stores. (AT, expose as HWCAP_USCAT)
>  3) LDAPR and STLR instructions with immediate offsets (extension to
>     LRCPC, exposed as HWCAP_ILRCPC)
>  4) Flag manipulation instructions (TS, exposed as HWCAP_FLAGM).

Please resend this but continuing with the default of FTR_STRICT, as we
currently have. That way this can be merged while we work out what we want
to do there.

> While at it get rid of the RES0 entries in the cpu-feature-registers.txt
> documentation, as:
>  1) We care only about the user visible fields.
>  2) The field may not be up-to-date
>  3) We already explain the rules of the fields if it is not visible.

Please spin this part as a separate patch.

Will
