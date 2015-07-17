From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 17 Jul 2015 12:09:15 +0200
Subject: [PATCH v2 3/7] KVM: irqchip: convey devid to kvm_set_msi
In-Reply-To: <01d401d0c062$086c2ee0$19448ca0$@samsung.com>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <1436430137-24205-4-git-send-email-eric.auger@linaro.org>
 <01d401d0c062$086c2ee0$19448ca0$@samsung.com>
Message-ID: <55A8D44A.3030105@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/07/2015 09:27, Pavel Fedin wrote:
>> > +	} else if (!msi->flags)
>> > +		return -EINVAL;
>  Did you mean "if (msg->flags)" here (inverted condition)?

Indeed, and also you need { } around the return for the QEMU coding
standard.

Paolo

>> > +
>> > +	/* historically the route.type was not set */
>> > +
