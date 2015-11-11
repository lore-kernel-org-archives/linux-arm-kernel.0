From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 09:49:48 +0100
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <CABg9mcux0wEC5=nWuR9o8NwUTp73zqZ-N2e67_f7oS_mX1XGdg@mail.gmail.com>
References: <1447195301-16757-1-git-send-email-yang.shi@linaro.org>
 <20151111004208.GA47378@ast-mbp.thefacebook.com>
 <CABg9mcux0wEC5=nWuR9o8NwUTp73zqZ-N2e67_f7oS_mX1XGdg@mail.gmail.com>
Message-ID: <4902833.k8y8bz0YLV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 18:52:45 Z Lim wrote:
> On Tue, Nov 10, 2015 at 4:42 PM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Nov 10, 2015 at 04:26:02PM -0800, Shi, Yang wrote:
> >> On 11/10/2015 4:08 PM, Eric Dumazet wrote:
> >> >On Tue, 2015-11-10 at 14:41 -0800, Yang Shi wrote:
> >> >>aarch64 doesn't have native support for XADD instruction, implement it by
> >> >>the below instruction sequence:
> 
> aarch64 supports atomic add in ARMv8.1.
> For ARMv8(.0), please consider using LDXR/STXR sequence.

Is it worth optimizing for the 8.1 case? It would add a bit of complexity
to make the code depend on the CPU feature, but it's certainly doable.

	Arnd
