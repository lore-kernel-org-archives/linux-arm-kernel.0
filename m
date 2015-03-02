From: lersek@redhat.com (Laszlo Ersek)
Date: Mon, 02 Mar 2015 17:55:44 +0100
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <54F49418.5070108@redhat.com>
References: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150219165731.GA26965@hawk.usersys.redhat.com>
 <CAKv+Gu8Je3RRrgEFCZ7JUWtOgk3WqA_qdBEOPAMc3OqnKr1bwg@mail.gmail.com>
 <20150219175518.GB26965@hawk.usersys.redhat.com>
 <54E62404.9040702@redhat.com>
 <20150220142905.GA10942@hawk.usersys.redhat.com>
 <CAKv+Gu-YUzmnACZQi98OPRgKKL+gAGqwWYq2-_dwCdNqcktNUg@mail.gmail.com>
 <20150220153626.GB10942@hawk.usersys.redhat.com>
 <20150224145529.GA5498@hawk.usersys.redhat.com>
 <CAKv+Gu-Uk2wg1OkoWgQe4da_EiFoEz_u8VuD8Ees6qU1UYMDvQ@mail.gmail.com>
 <20150302163146.GB9686@lvm> <54F49418.5070108@redhat.com>
Message-ID: <54F49610.6090000@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/15 17:47, Paolo Bonzini wrote:
> 
> Also, we may want to invalidate the cache for dirty pages before
> returning the dirty bitmap, and probably should do that directly in
> KVM_GET_DIRTY_LOG.

"I agree."

If KVM_GET_DIRTY_LOG is supposed to be atomic fetch and clear (from
userspace's aspect), then the cache invalidation should be an atomic
part of it too (from the same aspect).

(Sorry if I just said something incredibly stupid.)

Laszlo
