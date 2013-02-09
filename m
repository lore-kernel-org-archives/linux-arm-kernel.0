From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 09 Feb 2013 23:52:03 +0100
Subject: [PATCH v4 02/10] s5p-fimc: Add device tree support for FIMC
 devices
In-Reply-To: <5116CDBB.4080807@gmail.com>
References: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
 <1359745771-23684-3-git-send-email-s.nawrocki@samsung.com>
 <5112E9EF.8090908@wwwdotorg.org> <5115874A.6050406@gmail.com>
 <51158873.3060508@wwwdotorg.org> <511592B4.5050406@gmail.com>
 <5115991E.7050009@wwwdotorg.org> <5116CDBB.4080807@gmail.com>
Message-ID: <5116D313.8000603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2013 11:29 PM, Sylwester Nawrocki wrote:
>
>> After all, what happens in some later SoC where you have two different
>> types of module that feed into the common module, such that type A
>> sources have IDs 0..3 in the common module, and type B sources have IDs
>> 4..7 in the common module - you wouldn't want to require alias ISs 4..7
>> for the type B DT nodes.

I forgot to add, any ID remapping could happen in the common module, if
it requires it. Type A and type B sources could have indexes 0...3 and
the common module could derive its configuration from the source ID *and*
the source type. The idea behind aliases was to identify each instance,
rather than providing an exact configuration data that the common module
could use.
