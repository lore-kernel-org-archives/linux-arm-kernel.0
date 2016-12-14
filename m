From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 14 Dec 2016 17:35:53 +0100
Subject: [PATCH 1/1] arm64: Correcting format specifier for printing 64
 bit addresses
In-Reply-To: <20161206161116.GD4816@cbox>
References: <1480925393-8386-1-git-send-email-maninder1.s@samsung.com>
 <20161206161116.GD4816@cbox>
Message-ID: <65935935-bdd9-c6a6-1a33-2bbaf6ffbbc5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/12/2016 17:11, Christoffer Dall wrote:
> +		kvm_err("Unsupported guest CP%d access at: %08lx\n",
> +			cp, *vcpu_pc(vcpu));
> +	else
> +		kvm_err("Unsupported guest CP%d access at: %016lx\n",
> +			cp, *vcpu_pc(vcpu));
> 
> It feels a bit much to me to have an if-statement to differentiate the
> number of leading zeros, so if it's important to always have fixed
> widths then I would just use %016lx in both cases.

Really, this is just a debugging message.  Just use "0x%lx" and let's
stop bikeshedding. :)

Paolo
