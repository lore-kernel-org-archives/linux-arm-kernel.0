From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 24 Nov 2014 13:59:22 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <5473A0F7.10308@codeaurora.org>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <546FC674.1070005@codeaurora.org>
 <CAJAp7OiLwMQEYFr9xdLg=S=cAPtN+hKZq3j5iSe0oL_Qz3URwg@mail.gmail.com>
 <5473A0F7.10308@codeaurora.org>
Message-ID: <20141124215921.GA2872@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 24 Nov 13:19 PST 2014, Stephen Boyd wrote:

[..]
> 
> What exactly are we circumventing? I can only guess that we're talking
> about the aggregation logic?
> 

We're circumventing the fact that the regulator core doesn't have knowledge
about our multiple presented views of the same resource.

As the downstream driver shows, if we just implement the right pieces it should
work, i.e. give us the correct end result, but it will not be future proof nor
pretty. That's why I think we need to discuss how to solve it either in the
regulator driver or in the framework.

And based on your feedback, it looks like we would have to do something about
this in the framework.

Regards,
Bjorn
