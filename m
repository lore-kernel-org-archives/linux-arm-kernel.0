From: labbott@redhat.com (Laura Abbott)
Date: Wed, 21 Feb 2018 17:35:24 -0800
Subject: [PATCH 2/2] arm64: Clear the stack
In-Reply-To: <3b76d238-e10a-9abf-c9cb-6d3738eb7896@redhat.com>
References: <20180221011303.20392-1-labbott@redhat.com>
 <20180221011303.20392-3-labbott@redhat.com>
 <20180221153850.ywpzsigfnz3etoun@salmiak>
 <3b76d238-e10a-9abf-c9cb-6d3738eb7896@redhat.com>
Message-ID: <572af610-c20f-e826-f124-8df47680795b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2018 03:53 PM, Laura Abbott wrote:
>> I *think* this should happen in finish_ret_to_user a few lines down, since we
>> can call C code if we branch to work_pending, dirtying the stack.
>>
> 
> I think you're right but this didn't immediately work when I tried it.
> I'll have to dig into this some more.

Okay I figured this out. Not corrupting registers works wonders.
