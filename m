From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 7 Jul 2015 13:21:38 +0200
Subject: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <E959C4978C3B6342920538CF579893F0025F3568@SHSMSX104.ccr.corp.intel.com>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-4-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025F342B@SHSMSX104.ccr.corp.intel.com>
 <559BB167.1030603@redhat.com>
 <E959C4978C3B6342920538CF579893F0025F34FC@SHSMSX104.ccr.corp.intel.com>
 <559BB463.6090406@redhat.com>
 <E959C4978C3B6342920538CF579893F0025F3568@SHSMSX104.ccr.corp.intel.com>
Message-ID: <559BB642.5010701@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/07/2015 13:18, Wu, Feng wrote:
> Then I still need assign prod and de-assign prod in
> irq_bypass_register_consumer/irq_bypass_unregister_consumer, Right?
> Would you please share why this is better.

The need to store the consumer->producer link seems to be unique to
posted interrupts.  It is difficult to say without seeing the PI code,
but I prefer to keep the bypass manager as small as possible.

Paolo
