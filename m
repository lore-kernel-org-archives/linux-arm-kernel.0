From: bp@alien8.de (Borislav Petkov)
Date: Wed, 21 Oct 2015 11:35:36 +0200
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <5626F09F.4050107@huawei.com>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151019205236.GB453@leverpostej> <56266F7E.6030404@amd.com>
 <20151020165744.GE31130@pd.tnic>
 <20151020172654.GC4943@leverpostej>
 <20151020173639.GH31130@pd.tnic> <5626F09F.4050107@huawei.com>
Message-ID: <20151021093536.GA3575@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 09:55:43AM +0800, Hanjun Guo wrote:
> So I think the meaning of those error register is the same, but the way
> of handle it may different from SoCs, for single bit error:
> 
>  - SoC may trigger a interrupt;
>  - SoC may just keep silent so we need to scan the registers using poll
>    mechanism.
> 
> For Double bit error:
>   - SoC may also keep silent
>   - Trigger a interrupt
>   - Trigger a SEI (system error)
> 
> Any suggestion to cover those cases?

Well, I guess we can implement all those and have them configurable
in the sense that a single driver loads, it has all functionality and
dependent on the vendor detection, it does only what the vendor wants
like trigger an interrupt or remain silent or ...

Btw, in talking about this with Andre last night, he had the suggestion
that this functionality is also in other implementations besides A57 so
maybe the driver should be called arm_cortex_edac...

Just putting it out there and adding Andre to CC.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
